package msfgui;

import javax.swing.JFileChooser;

/**
 * Options dialog for file collector script
 * @author scriptjunkie
 */
public class SearchDwldOptionsDialog extends OptionsDialog {

    /** Creates new form SearchDwldOptionsDialog */
    public SearchDwldOptionsDialog(java.awt.Frame parent, String currentDir) {
        super(parent, "Search/Download Options", true);
        initComponents();
		dirField.setText(currentDir);
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonGroup1 = new javax.swing.ButtonGroup();
        okButton = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        dirField = new javax.swing.JTextField();
        jLabel2 = new javax.swing.JLabel();
        searchPatternField = new javax.swing.JTextField();
        outputDirField = new javax.swing.JTextField();
        outDirButton = new javax.swing.JButton();
        recursiveBox = new javax.swing.JCheckBox();

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                closeDialog(evt);
            }
        });

        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(msfgui.MsfguiApp.class).getContext().getResourceMap(SearchDwldOptionsDialog.class);
        okButton.setText(resourceMap.getString("okButton.text")); // NOI18N
        okButton.setName("okButton"); // NOI18N
        okButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                okButtonActionPerformed(evt);
            }
        });

        jLabel1.setText(resourceMap.getString("jLabel1.text")); // NOI18N
        jLabel1.setName("jLabel1"); // NOI18N

        dirField.setText(resourceMap.getString("dirField.text")); // NOI18N
        dirField.setName("dirField"); // NOI18N

        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        searchPatternField.setText(resourceMap.getString("searchPatternField.text")); // NOI18N
        searchPatternField.setName("searchPatternField"); // NOI18N

        outputDirField.setText(resourceMap.getString("outputDirField.text")); // NOI18N
        outputDirField.setName("outputDirField"); // NOI18N

        outDirButton.setText(resourceMap.getString("outDirButton.text")); // NOI18N
        outDirButton.setName("outDirButton"); // NOI18N
        outDirButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                outDirButtonActionPerformed(evt);
            }
        });

        recursiveBox.setSelected(true);
        recursiveBox.setText(resourceMap.getString("recursiveBox.text")); // NOI18N
        recursiveBox.setName("recursiveBox"); // NOI18N

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(dirField, javax.swing.GroupLayout.DEFAULT_SIZE, 322, Short.MAX_VALUE))
                    .addComponent(okButton, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(searchPatternField, javax.swing.GroupLayout.DEFAULT_SIZE, 404, Short.MAX_VALUE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(recursiveBox))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(outDirButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(outputDirField, javax.swing.GroupLayout.DEFAULT_SIZE, 418, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(dirField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(recursiveBox)
                    .addComponent(jLabel2)
                    .addComponent(searchPatternField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(outputDirField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(outDirButton))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(okButton)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void okButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_okButtonActionPerformed
		StringBuilder cmd = new StringBuilder("file_collector");
		if(dirField.getText().length() > 0)
			cmd.append(" -d ").append(MsfguiApp.escapeBackslashes(dirField.getText()));
		cmd.append(" -l ").append(outputDirField.getText());
		if(recursiveBox.isSelected())
			cmd.append(" -r ");
		cmd.append(" -f ").append(searchPatternField.getText());
		String tempFileName = MsfguiApp.getTempFilename("foundfiles", ".txt");
		cmd.append(" -o ").append(MsfguiApp.escapeBackslashes(tempFileName));
		cmd.append(" -i ").append(MsfguiApp.escapeBackslashes(tempFileName));
		command = cmd.toString();
		doClose();
    }//GEN-LAST:event_okButtonActionPerformed

    /** Closes the dialog */
    private void closeDialog(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_closeDialog
        doClose();
    }//GEN-LAST:event_closeDialog

	private void outDirButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_outDirButtonActionPerformed
		JFileChooser choosy = MsfguiApp.fileChooser;
		int mode = choosy.getFileSelectionMode();
		choosy.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		if(choosy.showOpenDialog(this) == JFileChooser.APPROVE_OPTION)
			outputDirField.setText(choosy.getCurrentDirectory().getPath());
		choosy.setFileSelectionMode(mode);
	}//GEN-LAST:event_outDirButtonActionPerformed

    private void doClose() {
        setVisible(false);
        dispose();
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.JTextField dirField;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JButton okButton;
    private javax.swing.JButton outDirButton;
    private javax.swing.JTextField outputDirField;
    private javax.swing.JCheckBox recursiveBox;
    private javax.swing.JTextField searchPatternField;
    // End of variables declaration//GEN-END:variables

}
