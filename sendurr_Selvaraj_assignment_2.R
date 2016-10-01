attach("/Users/Sendurr/Dropbox/Transfer/CSCE587 - Big Data/IntermediateR.RData")
no_of_sudo = dim(sudokus)[3]
no_of_column = dim(sudokus)[2]
no_of_row = dim(sudokus)[1]
result=c();
# function to check unique numbers
validate = function(a){
  x = unique(a,incomparables = TRUE);
  if (length(x) == 9){
    return(TRUE);
  }
  else{
    return(FALSE);
  }
}

# loop all the given sudoku sets
for (i in 1:no_of_sudo){
  #column check
  for (j in 1:no_of_column){
    a=sudokus[,j,i];
    check = validate(a);
    if(check == FALSE){
      break;
    }
  }
  if(check == FALSE){
    next;
  }
  #row check
  for (j in 1:no_of_row){
    a=sudokus[j,,i];
    check = validate(a);
    if(check == FALSE){
      break;
    }
  }
  if(check == FALSE){
    next;
  }
  #matrix check
  for (j in 1:(no_of_column/3)){
    col_end = j*3;
    col_start = col_end -2;
    for (k in 1:(no_of_row/3)){
      row_end = k*3;
      row_start = row_end -2;
      a=sudokus[row_start:row_end,col_start:col_end,1];
      check = validate(as.vector(a));
      if(check == FALSE){
        break;
      }
    }
    if(check == FALSE){
      break;
    }
  }
  result=append(result,i);
}

print("The genuine sudoku sets are given below thru their index.")
print(result);
