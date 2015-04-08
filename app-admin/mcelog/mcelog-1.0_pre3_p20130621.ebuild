# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mcelog/mcelog-1.0_pre3_p20130621.ebuild,v 1.1 2013/07/10 18:35:53 hasufell Exp $

EAPI=5

inherit linux-info eutils toolchain-funcs vcs-snapshot

COMMIT="b842ecb44965722ecd67bed1ed9d900073e3313f"
DESCRIPTION="A tool to log and decode Machine Check Exceptions"
HOMEPAGE="http://mcelog.org/"
SRC_URI="https://github.com/andikleen/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="selinux"

RDEPEND="selinux? ( sec-policy/selinux-mcelog )"

CONFIG_CHECK="~X86_MCE"

# TODO: add mce-inject to the tree to support test phase
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8_pre1-timestamp-${PN}.patch \
		"${FILESDIR}"/${PN}-1.0_pre3_p20120918-build.patch \
		"${FILESDIR}"/${PN}-1.0_pre3_p20120918-bashism.patch
	tc-export CC
}

src_install() {
	dosbin ${PN}

	insinto /etc/cron.daily
	newins ${PN}.cron ${PN}

	insinto /etc/logrotate.d/
	newins ${PN}.logrotate ${PN}

	newinitd "${FILESDIR}"/${PN}.init ${PN}

	insinto /etc/${PN}
	doins mcelog.conf
	exeinto /etc/${PN}
	doexe triggers/*

	dodoc CHANGES README TODO *.pdf
	doman ${PN}.8
}

pkg_postinst() {
	einfo "The default configuration set is now installed in /etc/${PN}"
	einfo "you might want to edit those files."
	einfo
	einfo "A sample cronjob is installed into /etc/cron.daily"
	einfo "without executable bit (system service is the preferred method now)"
}
