# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-data/microcode-data-20120606.ebuild,v 1.3 2012/09/23 08:15:03 phajdan.jr Exp $

EAPI=4

inherit toolchain-funcs

NUM="21385"
DESCRIPTION="Intel IA32 microcode update data"
HOMEPAGE="http://urbanmyth.org/microcode/"
SRC_URI="http://downloadmirror.intel.com/${NUM}/eng/microcode-${PV}.tgz"

LICENSE="intel-ucode"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!<sys-apps/microcode-ctl-1.17-r2" #268586

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/intel-microcode2ucode.c ./ || die
}

src_compile() {
	tc-env_build emake intel-microcode2ucode
	./intel-microcode2ucode microcode.dat || die
}

src_install() {
	insinto /lib/firmware
	doins -r microcode.dat intel-ucode
}

pkg_postinst() {
	elog "The microcode available for Intel CPUs has been updated.  You'll need"
	elog "to reload the code into your processor.  If you're using the init.d:"
	elog "/etc/init.d/microcode_ctl restart"
}
