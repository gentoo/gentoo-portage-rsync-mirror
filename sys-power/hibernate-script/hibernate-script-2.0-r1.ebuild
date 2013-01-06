# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/hibernate-script/hibernate-script-2.0-r1.ebuild,v 1.3 2009/06/03 22:02:01 cla Exp $

inherit eutils

PATCH_VERSION="1"

DESCRIPTION="Hibernate script supporting multiple suspend methods"
HOMEPAGE="http://www.tuxonice.net/"
SRC_URI="http://www.tuxonice.net/downloads/all/${P}.tar.gz
	mirror://gentoo/${PN}-1.98.1-patches-${PATCH_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE="vim-syntax"

DEPEND=""
RDEPEND="!<media-gfx/splashutils-1.5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-init.d.patch"
}

src_install() {
	BASE_DIR="${D}" \
		DISTRIBUTION="gentoo" \
		PREFIX="/usr" \
		MAN_DIR="${D}/usr/share/man" \
		"${S}/install.sh" || die "Install failed"

	# hibernate-ram will default to using ram.conf
	dosym /usr/sbin/hibernate /usr/sbin/hibernate-ram

	newinitd "${S}"/init.d/hibernate-cleanup.sh hibernate-cleanup

	# other ebuilds can install scriplets to this dir
	keepdir /etc/hibernate/scriptlets.d/

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins hibernate.vim
	fi

	dodoc CHANGELOG README SCRIPTLET-API hibernate.vim

	insinto /etc/logrotate.d
	newins "${S}"/logrotate.d-hibernate-script hibernate-script
}

pkg_postinst() {
	elog
	elog "You should run the following command to invalidate suspend"
	elog "images on a clean boot."
	elog
	elog "  # rc-update add hibernate-cleanup boot"
	elog
	elog "See /usr/share/doc/${PF}/README.* for further details."
	elog
	elog "Please note that you will need to manually emerge any utilities"
	elog "(radeontool, vbetool, ...) enabled in the configuration files,"
	elog "should you wish to use them."
}
