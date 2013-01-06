# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_authn_pam/mod_authn_pam-0.0.1.ebuild,v 1.2 2008/05/14 23:17:29 flameeyes Exp $

inherit eutils apache-module

DESCRIPTION="PAM authentication module for Apache."
HOMEPAGE="http://mod-auth.sourceforge.net/docs/mod_authn_pam/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c ${PN}.c -lpam"
APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="AUTHN_PAM"

need_apache2_2

src_install() {
	apache-module_src_install
	insinto /etc/pam.d
	newins "${FILESDIR}"/apache2.pam apache2
}
