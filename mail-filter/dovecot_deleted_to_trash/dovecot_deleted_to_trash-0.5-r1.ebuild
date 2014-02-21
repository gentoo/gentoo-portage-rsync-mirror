# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dovecot_deleted_to_trash/dovecot_deleted_to_trash-0.5-r1.ebuild,v 1.1 2014/02/21 09:04:06 civil Exp $

EAPI=5

inherit toolchain-funcs base

DESCRIPTION="Deleted to trash IMAP plugin for Dovecot"
HOMEPAGE="https://github.com/lexbrugman/dovecot_deleted_to_trash"
SRC_URI="http://rion-overlay.googlecode.com/files/dovecot_deleted_to_trash-0.5.tar.bz2"

LICENSE="ZLIB"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE=""
RDEPEND="=net-mail/dovecot-2.2*
	!!<net-mail/dovecot-2.2.0
	!!<=mail-filter/dovecot_deleted_to_trash-0.3
	"

DEPEND="${RDEPEND}
	app-arch/unzip
	"

PATCHES=( "${FILESDIR}"/fix_names_and_destdir.patch )

#S="${WORKDIR}"

src_compile() {
	tc-export CC
	base_src_compile
}

src_install() {
	base_src_install

	insinto /etc/dovecot/conf.d
	doins "${FILESDIR}"/29-delete-to-trash.conf
}
