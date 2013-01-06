# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ApE/ApE-2.0.7-r1.ebuild,v 1.1 2012/12/31 18:16:06 je_fro Exp $

EAPI=2
inherit eutils

DESCRIPTION="ApE - A Plasmid Editor"
HOMEPAGE="http://www.biology.utah.edu/jorgensen/wayned/ape/"
SRC_URI="http://www.biology.utah.edu/jorgensen/wayned/ape/Download/Linux/ApE_linux_current.zip -> ${P}.zip"

LICENSE="ApE"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-lang/tcl
	 dev-lang/tk"

src_compile() {
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {

cat >> "${T}/ApE" << "EOF"
#!/bin/bash
cmdArgs=""

# AppMain.tcl searches files relative to the directory where it resides.
# Add absolute path to file here, if necessary.
for rfpath in "$@"; do
	afpath="$PWD/${rfpath}"
	if test -r "${afpath}"; then
	cmdArgs="${cmdArgs} \"${afpath}\"";
else
	cmdArgs="${cmdArgs} \"${rfpath}\"";
fi
done

eval exec tclsh "\"/usr/share/ApE-2.0.7/AppMain.tcl\"" "${cmdArgs}"
EOF

exeinto /usr/bin
doexe "${T}/ApE"
insinto "/usr/share/${P}"
doins -r "${WORKDIR}"/ApE\ Linux/*
make_desktop_entry ${PN} \
		ApE \
		"/usr/share/${P}/Accessory Files/Icons and images/monkey_icon.gif" \
		"Application;Graphics;Science"
}
