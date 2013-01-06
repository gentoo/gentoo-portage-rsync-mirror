# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_krb5/pam_krb5-4.6.ebuild,v 1.1 2012/06/03 12:27:14 eras Exp $

EAPI=4

inherit multilib

DESCRIPTION="Kerberos 5 PAM Authentication Module"
HOMEPAGE="http://www.eyrie.org/~eagle/software/pam-krb5"
SRC_URI="http://archives.eyrie.org/software/kerberos/pam-krb5-${PV}.tar.gz"

LICENSE="|| ( BSD-2 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/krb5
		virtual/pam"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_/-}"

src_configure() {
	econf \
		  --libdir=/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README TODO

	rm "${D}/$(get_libdir)/security/pam_krb5.la"
}
