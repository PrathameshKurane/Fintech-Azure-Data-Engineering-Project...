@equals(int(string(activity('sourceCount').output.firstRow.sourceCount)),
int(string(activity('target_count').output.resultsets[0].rows[0].target_count)))