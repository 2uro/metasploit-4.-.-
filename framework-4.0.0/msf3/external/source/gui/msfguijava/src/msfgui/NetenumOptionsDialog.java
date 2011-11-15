package msfgui;

import javax.swing.JFileChooser;

/**
 * Options dialog for the netenum script
 * @author scriptjunkie
 */
public class NetenumOptionsDialog extends OptionsDialog {
    /** Creates new form NetenumOptionsDialog */
    public NetenumOptionsDialog(java.awt.Frame parent) {
        super(parent, "Netenum options", true);
        initComponents();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        okButton = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        addressField = new javax.swing.JTextField();
        pingBox = new javax.swing.JCheckBox();
        reverseDnsBox = new javax.swing.JCheckBox();
        forwardBox = new javax.swing.JCheckBox();
        mxNsBox = new javax.swing.JCheckBox();
        serviceBox = new javax.swing.JCheckBox();
        jLabel2 = new javax.swing.JLabel();
        domainField = new javax.swing.JTextField();
        fileField = new javax.swing.JTextField();
        chooseButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(msfgui.MsfguiApp.class).getContext().getResourceMap(NetenumOptionsDialog.class);
        okButton.setText(resourceMap.getString("okButton.text")); // NOI18N
        okButton.setName("okButton"); // NOI18N
        okButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                okButtonActionPerformed(evt);
            }
        });

        jLabel1.setText(resourceMap.getString("jLabel1.text")); // NOI18N
        jLabel1.setName("jLabel1"); // NOI18N

        addressField.setText(resourceMap.getString("addressField.text")); // NOI18N
        addressField.setName("addressField"); // NOI18N

        pingBox.setText(resourceMap.getString("pingBox.text")); // NOI18N
        pingBox.setName("pingBox"); // NOI18N

        reverseDnsBox.setText(resourceMap.getString("reverseDnsBox.text")); // NOI18N
        reverseDnsBox.setName("reverseDnsBox"); // NOI18N

        forwardBox.setText(resourceMap.getString("forwardBox.text")); // NOI18N
        forwardBox.setName("forwardBox"); // NOI18N

        mxNsBox.setText(resourceMap.getString("mxNsBox.text")); // NOI18N
        mxNsBox.setName("mxNsBox"); // NOI18N

        serviceBox.setText(resourceMap.getString("serviceBox.text")); // NOI18N
        serviceBox.setName("serviceBox"); // NOI18N

        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        domainField.setText(resourceMap.getString("domainField.text")); // NOI18N
        domainField.setName("domainField"); // NOI18N

        fileField.setText(resourceMap.getString("fileField.text")); // NOI18N
        fileField.setName("fileField"); // NOI18N

        chooseButton.setText(resourceMap.getString("chooseButton.text")); // NOI18N
        chooseButton.setName("chooseButton"); // NOI18N
        chooseButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                chooseButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(forwardBox)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(addressField, javax.swing.GroupLayout.DEFAULT_SIZE, 196, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(pingBox)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(reverseDnsBox))
                    .addComponent(mxNsBox)
                    .addComponent(serviceBox)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(domainField, javax.swing.GroupLayout.DEFAULT_SIZE, 292, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(chooseButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(fileField, javax.swing.GroupLayout.DEFAULT_SIZE, 198, Short.MAX_VALUE))
                    .addComponent(okButton, javax.swing.GroupLayout.Alignment.TRAILING))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(addressField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(reverseDnsBox)
                    .addComponent(pingBox))
                .addGap(18, 18, 18)
                .addComponent(mxNsBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(serviceBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(domainField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(forwardBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(fileField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(chooseButton))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(okButton)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

	private void chooseButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_chooseButtonActionPerformed
		if(MsfguiApp.fileChooser.showOpenDialog(this) == JFileChooser.APPROVE_OPTION)
			fileField.setText(MsfguiApp.fileChooser.getSelectedFile().getPath());
	}//GEN-LAST:event_chooseButtonActionPerformed

	private void okButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_okButtonActionPerformed
		StringBuilder cmd = new StringBuilder("netenum ");
		if(addressField.getText().length() > 0)
			cmd.append(" -r ").append(addressField.getText());
		if(pingBox.isSelected())
			cmd.append(" -ps");
		if(reverseDnsBox.isSelected())
			cmd.append(" -rl");
		if(forwardBox.isSelected())
			cmd.append(" -fl");
		if(fileField.getText().length() > 0)
			cmd.append(" -hl ").append(MsfguiApp.escapeBackslashes(fileField.getText()));
		if(domainField.getText().length() > 0)
			cmd.append(" -d ").append(domainField.getText());
		if(mxNsBox.isSelected())
			cmd.append(" -st");
		if(serviceBox.isSelected())
			cmd.append(" -sr");
		command = cmd.toString();
		setVisible(false);
		dispose();
	}//GEN-LAST:event_okButtonActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField addressField;
    private javax.swing.JButton chooseButton;
    private javax.swing.JTextField domainField;
    private javax.swing.JTextField fileField;
    private javax.swing.JCheckBox forwardBox;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JCheckBox mxNsBox;
    private javax.swing.JButton okButton;
    private javax.swing.JCheckBox pingBox;
    private javax.swing.JCheckBox reverseDnsBox;
    private javax.swing.JCheckBox serviceBox;
    // End of variables declaration//GEN-END:variables

}
