# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.18.0_p20120124.ebuild,v 1.4 2012/05/21 09:50:29 phajdan.jr Exp $

EAPI=2
inherit eutils linux-mod

MY_P=${P/-modules}

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.hg.sourceforge.net/hgweb/dxr3/em8300/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
		http://vdr.websitec.de/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/linux-sources"

CONFIG_CHECK="I2C_ALGOBIT"
MODULE_NAMES="em8300(video:) bt865(video:) adv717x(video:)"

S=${WORKDIR}/${MY_P}/modules

src_prepare() {
	# disable the hg versioning, mercurial install needed
	rm "${S}/update_em8300_version.sh"
	echo "#define EM8300_VERSION \"20120124\"" > "${S}/em8300_version.h"
}

src_compile() {
	set_arch_to_kernel
	emake KERNEL_LOCATION="${KERNEL_DIR}" || die
}

src_install() {
	linux-mod_src_install

	dodoc README-modoptions README-modules.conf

	newsbin devices.sh em8300-devices.sh

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/modules.em8300 em8300.conf

	insinto /etc/udev/rules.d
	newins em8300-udev.rules 15-em8300.rules
}

pkg_preinst() {
	linux-mod_pkg_preinst

	local old1="${ROOT}/etc/modprobe.d/em8300"
	local old2="${ROOT}/etc/modules.d/em8300"
	local new="${ROOT}/etc/modprobe.d/em8300.conf"

	if [[ ! -a ${new} ]]; then
		if [[ -a ${old1} ]]; then
			elog "Renaming em8300-modprobe configuration to em8300.conf"
			mv "${old1}" "${new}"
		elif [[ -a ${old2} ]]; then
			elog "Moving old em8300 configuration in /etc/modules.d to new"
			elog "location in /etc/modprobe.d"
			mv "${old2}" "${new}"
		fi
	fi
}
