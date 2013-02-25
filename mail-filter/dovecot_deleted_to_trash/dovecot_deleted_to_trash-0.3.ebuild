# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dovecot_deleted_to_trash/dovecot_deleted_to_trash-0.3.ebuild,v 1.7 2013/02/25 13:31:45 ago Exp $

EAPI=4

inherit base multilib toolchain-funcs

DESCRIPTION="Deleted to trash IMAP plugin for Dovecot"
HOMEPAGE="http://wiki.dovecot.org/Plugins/deleted-to-trash"
SRC_URI="http://wiki2.dovecot.org/Plugins/deleted-to-trash?action=AttachFile&do=get&target=deleted-to-trash-plugin_${PV}_for_dovecot_2.tar -> ${P}.tar"

LICENSE="ZLIB" # ZLIB without 3rd clause
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="=net-mail/dovecot-2.0*"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	sed -e "/DOVECOT_IMAP_PLUGIN_PATH/s/lib/$(get_libdir)/g"  \
		-e "/DOVECOT_IMAP_PLUGIN_PATH/s/imap//" \
		-e "/PLUGIN_NAME/s/lib/lib99/" -i Makefile || die 'sed on Makefile failed'
	base_src_prepare
}

src_compile() {
	tc-export CC
	base_src_compile
}

src_install() {
	base_src_install

	insinto /etc/dovecot/conf.d
	doins "${FILESDIR}"/29-delete-to-trash.conf
}
