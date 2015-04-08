# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backup-manager/backup-manager-0.7.5.ebuild,v 1.7 2014/08/10 01:54:00 patrick Exp $

inherit eutils

DESCRIPTION="Backup Manager is a command line backup tool for GNU/Linux"
HOMEPAGE="http://www.backup-manager.org/"
SRC_URI="http://www.backup-manager.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="dev-lang/perl
	sys-devel/gettext"

RDEPEND="${DEPEND}
	>=sys-apps/findutils-4.3.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Makefile-fix.diff
}

src_compile() {
	# doing nothing, cause a call to make would start make install
	true
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	use doc && dodoc doc/user-guide.txt
}

pkg_postinst() {
	elog "After installing,"
	elog "copy ${ROOT%/}/usr/share/backup-manager/backup-manager.conf.tpl to"
	elog "/etc/backup-manager.conf and customize it for your environment."
	elog "You could also set-up your cron for daily or weekly backup."
	ebeep 3
	ewarn "New configuration keys have been defined. Please check the docs for info"
}
