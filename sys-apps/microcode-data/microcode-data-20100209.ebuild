# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-data/microcode-data-20100209.ebuild,v 1.3 2011/01/20 22:51:32 flameeyes Exp $

NUM="18683"
DESCRIPTION="Intel IA32 microcode update data"
HOMEPAGE="http://urbanmyth.org/microcode/"
SRC_URI="http://downloadmirror.intel.com/${NUM}/eng/microcode-${PV}.tgz"

LICENSE="intel-ucode"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!<sys-apps/microcode-ctl-1.17-r2" #268586

S=${WORKDIR}

src_install() {
	insinto /lib/firmware
	newins microcode-${PV}.dat microcode.dat || die
}

pkg_postinst() {
	einfo "The microcode available for Intel CPUs has been updated.  You'll need"
	einfo "to reload the code into your processor.  If you're using the init.d:"
	einfo "/etc/init.d/microcode_ctl restart"
}
