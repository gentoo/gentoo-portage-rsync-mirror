# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mit-krb5/mit-krb5-1.10.2-r1.ebuild,v 1.3 2012/12/16 19:38:25 ulm Exp $

EAPI=4
inherit eutils flag-o-matic versionator

MY_P="${P/mit-}"
P_DIR=$(get_version_component_range 1-2)
DESCRIPTION="MIT Kerberos V"
HOMEPAGE="http://web.mit.edu/kerberos/www/"
SRC_URI="http://web.mit.edu/kerberos/dist/krb5/${P_DIR}/${MY_P}-signed.tar"

LICENSE="openafs-krb5-a BSD MIT OPENLDAP BSD-2 HPND BSD-4 ISC RSA CCPL-Attribution-ShareAlike-3.0 || ( BSD-2 GPL-2+ )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="doc +keyutils openldap +pkinit +threads test xinetd"

RDEPEND="!!app-crypt/heimdal
	>=sys-libs/e2fsprogs-libs-1.41.0
	dev-libs/libverto
	keyutils? ( sys-apps/keyutils )
	openldap? ( net-nds/openldap )
	pkinit? ( dev-libs/openssl )
	xinetd? ( sys-apps/xinetd )"
DEPEND="${RDEPEND}
	virtual/yacc
	doc? ( virtual/latex-base )
	test? ( dev-lang/tcl
			dev-lang/python
			dev-util/dejagnu )"

S=${WORKDIR}/${MY_P}/src

src_unpack() {
	unpack ${A}
	unpack ./"${MY_P}".tar.gz
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.10.1_uninitialized_extra.patch"
	epatch "${FILESDIR}/${PN}-1.10.1_uninitialized_extra-2.patch"
	epatch "${FILESDIR}/${PN}-1.10.1_gcc470.patch"
	epatch "${FILESDIR}"/CVE-2012-1014.patch
	epatch "${FILESDIR}"/CVE-2012-1015.patch
}

src_configure() {
	append-cppflags "-I${EPREFIX}/usr/include/et"
	# QA
	append-flags -fno-strict-aliasing
	append-flags -fno-strict-overflow
	[[ $(gcc-version) == "4.7" ]] && replace-flags -O? -O0

	use keyutils || export ac_cv_header_keyutils_h=no
	econf \
		$(use_with openldap ldap) \
		"$(use_with test tcl "${EPREFIX}/usr")" \
		$(use_enable pkinit) \
		$(use_enable threads thread-support) \
		--without-hesiod \
		--enable-shared \
		--with-system-et \
		--with-system-ss \
		--enable-dns-for-realm \
		--enable-kdc-lookaside-cache \
		--with-system-verto \
		--disable-rpath
}

src_compile() {
	emake -j1

	if use doc ; then
		cd ../doc
		for dir in api implement ; do
			emake -C "${dir}"
		done
	fi
}

src_install() {
	emake \
		DESTDIR="${D}" \
		EXAMPLEDIR="${EPREFIX}/usr/share/doc/${PF}/examples" \
		install

	# default database dir
	keepdir /var/lib/krb5kdc

	cd ..
	dodoc NOTICE README
	dodoc doc/*.{ps,txt}
	doinfo doc/*.info*
	dohtml -r doc/*.html

	if use doc ; then
		dodoc doc/{api,implement}/*.ps
	fi

	newinitd "${FILESDIR}"/mit-krb5kadmind.initd mit-krb5kadmind
	newinitd "${FILESDIR}"/mit-krb5kdc.initd mit-krb5kdc
	newinitd "${FILESDIR}"/mit-krb5kpropd.initd mit-krb5kpropd

	insinto /etc
	newins "${ED}/usr/share/doc/${PF}/examples/krb5.conf" krb5.conf.example
	insinto /var/lib/krb5kdc
	newins "${ED}/usr/share/doc/${PF}/examples/kdc.conf" kdc.conf.example

	if use openldap ; then
		insinto /etc/openldap/schema
		doins "${S}/plugins/kdb/ldap/libkdb_ldap/kerberos.schema"
	fi

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/kpropd.xinetd" kpropd
	fi
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-1.8.0" ; then
		elog "MIT split the Kerberos applications from the base Kerberos"
		elog "distribution.  Kerberized versions of telnet, rlogin, rsh, rcp,"
		elog "ftp clients and telnet, ftp deamons now live in"
		elog "\"app-crypt/mit-krb5-appl\" package."
	fi
}
