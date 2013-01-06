# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.3.23.ebuild,v 1.1 2012/12/16 20:55:51 radhermit Exp $

EAPI=4

PYTHON_DEPEND="tk? 2"
PYTHON_USE_WITH_OPT="tk"
PYTHON_USE_WITH="tk"

inherit python user

DESCRIPTION="the legendary remote-mail retrieval and forwarding utility"
HOMEPAGE="http://fetchmail.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="ssl nls kerberos hesiod tk socks"

RDEPEND="hesiod? ( net-dns/hesiod )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 >=dev-libs/openssl-0.9.6 )
	nls? ( virtual/libintl )
	!elibc_glibc? ( sys-libs/e2fsprogs-libs )
	socks? ( net-proxy/dante )"
DEPEND="${RDEPEND}
	sys-devel/flex
	nls? ( sys-devel/gettext )"

DOCS="FAQ FEATURES NEWS NOTES README README.NTLM README.SSL* TODO"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
	if use tk; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# don't compile during src_install
	: > "${S}"/py-compile
}

src_configure() {
	if use tk ; then
		export PYTHON=$(PYTHON -a)
	else
		export PYTHON=:
	fi
	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		$(use_enable nls) \
		$(use_with ssl ssl "${EPREFIX}/usr") \
		$(use kerberos && echo "--with-ssl=${EPREFIX}/usr") \
		$(use_with kerberos gssapi) \
		$(use_with kerberos kerberos5) \
		$(use_with hesiod) \
		$(use_with socks)
}

src_install() {
	# fetchmail's homedir (holds fetchmail's .fetchids)
	keepdir /var/lib/${PN}
	fowners ${PN}:${PN} /var/lib/${PN}
	fperms 700 /var/lib/${PN}

	default

	dohtml *.html

	newinitd "${FILESDIR}"/fetchmail.initd fetchmail
	newconfd "${FILESDIR}"/fetchmail.confd fetchmail

	docinto contrib
	local f
	for f in contrib/* ; do
		[ -f "${f}" ] && dodoc "${f}"
	done
}

pkg_postinst() {
	use tk && python_mod_optimize fetchmailconf.py

	elog "Please see /etc/conf.d/fetchmail if you want to adjust"
	elog "the polling delay used by the fetchmail init script."
}

pkg_postrm() {
	use tk && python_mod_cleanup fetchmailconf.py
}
