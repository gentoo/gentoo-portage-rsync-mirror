# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dovecot-antispam/dovecot-antispam-2.0_pre20120226.ebuild,v 1.2 2013/05/17 20:31:20 radhermit Exp $

EAPI="4"

inherit autotools

DESCRIPTION="A dovecot antispam plugin supporting multiple backends"
HOMEPAGE="http://wiki2.dovecot.org/Plugins/Antispam"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=net-mail/dovecot-2.1*"
RDEPEND="${DEPEND}"

DOCS=( README )

src_prepare() {
	AT_M4DIR="m4" eautoreconf
}

pkg_postinst() {
	elog
	elog "You will need to install mail-filter/dspam or app-text/crm114"
	elog "if you want to use the related backends in dovecot-antispam."
	elog
}
