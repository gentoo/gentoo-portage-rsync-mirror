# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm5/rpm5-5.3.5.ebuild,v 1.2 2012/08/21 03:39:33 ottxor Exp $

EAPI=4

PYTHON_DEPEND="2"

MY_PN="rpm"
MY_P="${MY_PN}-${PV}"

inherit eutils multilib python user versionator

DESCRIPTION="RPM Package Manager"
HOMEPAGE="http://rpm5.org/"
SRC_URI="http://rpm5.org/files/${MY_PN}/${MY_PN}-$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~ppc-macos"
IUSE="acl augeas berkdb +bzip2 crypt debug expat gnutls keyutils lua lzma nls nss openssl pcre perl pkcs11 readline ruby selinux sqlite ssl tcl uuid webdav-neon xar xattr +zlib"

RDEPEND="!app-arch/rpm
	dev-libs/beecrypt
	dev-libs/popt
	sys-apps/file
	acl? ( sys-apps/acl )
	augeas? ( app-admin/augeas )
	berkdb? ( sys-libs/db )
	bzip2? ( app-arch/bzip2 )
	crypt? ( dev-libs/libgcrypt )
	expat? ( dev-libs/expat )
	keyutils? ( sys-apps/keyutils )
	lua? ( dev-lang/lua )
	lzma? ( app-arch/xz-utils )
	pcre? ( dev-libs/libpcre )
	perl? ( dev-lang/perl )
	pkcs11? ( dev-libs/pakchois )
	readline? ( sys-libs/readline:0 )
	ruby? ( >=dev-lang/ruby-1.9 )
	selinux? (
		sys-libs/libselinux
		sys-libs/libsemanage
		sys-libs/libsepol
	)
	sqlite? ( dev-db/sqlite:3 )
	ssl? (
		nss? ( dev-libs/nss )
		openssl? ( dev-libs/openssl )
		gnutls? (
			dev-libs/libtasn1
			net-libs/gnutls
		)
	)
	tcl? ( dev-lang/tcl )
	uuid? ( dev-libs/ossp-uuid )
	webdav-neon? ( net-libs/neon )
	xar? ( app-arch/xar )
	xattr? ( sys-apps/attr )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	virtual/yacc
	nls? ( sys-devel/gettext )
"

REQUIRED_USE="
	ssl? (
		^^ (
			gnutls
			nss
			openssl
		)
	)
"

S="${WORKDIR}/${MY_P}"

pkg_setup () {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local myconf=""

	# default internal/external switches
	# crypto default is beecrypt, user can change this on runtime
	#   and we build beecrypt every time
	# tomcrypt is not in portage
	# cudf is not in portage
	# users usually do not want to use debug malloc
	myconf+="
		--with-usecrypto=beecrypt
		--with-beecrypt=external
		--with-file=external
		--with-popt=external
		--without-tomcrypt
		--without-cudf
		--without-dmalloc
	"

	# ssl handling
	# tasn1 is handled in most portage packages with gnutls, do the same
	if use ssl; then
		myconf+="
			$(use_with gnutls)
			$(use_with gnutls libtasn1)
			$(use_with nss)
			$(use_with openssl)
		"
	else
		myconf+="
			--without-gnutls
			--without-libtasn1
			--without-nss
			--without-openssl
		"
	fi

	# enable db if we use berkdb or sqlite
	if use berkdb || use sqlite; then
		myconf+="
			--with-dbsql=external
		"
	else
		myconf+="
			--without-dbsql
		"
	fi

	# for berkdb enable the options if possible
	if use berkdb; then
		myconf+="
			--with-db-largefile
			--with-db-rpc
		"
	fi

	# we need python by default anyway so always --with-python
	econf \
		--disable-rpath \
		--disable-dependency-tracking \
		--enable-build-pic \
		--enable-build-pie \
		--enable-largefile \
		--with-python \
		--without-pythonembed \
		--with-python-lib-dir="${EPREFIX}$(python_get_libdir)" \
		--with-python-inc-dir="${EPREFIX}$(python_get_includedir)" \
		$(use_enable nls) \
		$(use_enable debug build-debug) \
		$(use_with acl) \
		$(use_with augeas) \
		$(use_with berkdb db) \
		$(use_with bzip2) \
		$(use_with crypt gcrypt) \
		$(use_with expat) \
		$(use_with keyutils) \
		$(use_with lua lua external) \
		$(use_with lzma xz external) \
		$(use_with pcre pcre external) \
		$(use_with perl) \
		$(use_with pkcs11 pakchois) \
		$(use_with readline) \
		$(use_with selinux) \
		$(use_with selinux semanage) \
		$(use_with selinux sepol) \
		$(use_with sqlite) \
		$(use_with tcl) \
		$(use_with uuid) \
		$(use_with webdav-neon neon external) \
		$(use_with xar xar external) \
		$(use_with xattr attr) \
		$(use_with zlib) \
		${myconf}

	# TODO: see files/remaining-5.3.5.txt
	ewarn "This package is far from complete"
	ewarn "If you want to test it please see \"${FILESDIR}/remaining-5.3.5.txt\""
	ewarn "and implement missing features."
	ewarn "Do NOT report bugs without providing patches!"
}

src_install() {
	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die "emake install failed"
	dodoc CHANGES CREDITS NEWS README TODO
}

pkg_preinst() {
	enewgroup rpm 37
	enewuser rpm 37 /bin/sh /var/lib/rpm rpm
}

pkg_postinst() {
	chown -R rpm:rpm "${EROOT}"/usr/$(get_libdir)/rpm
	chown -R rpm:rpm "${EROOT}"/var/lib/rpm
	chown rpm:rpm "${EROOT}"/usr/bin/rpm{,2cpio,build,constant}
	if [[ ${ROOT} == "/" ]] ; then
		if [[ -f ${EROOT}/var/lib/rpm/Packages ]] ; then
			einfo "RPM database found... Rebuilding database (may take a while)..."
			"${EROOT}"/usr/bin/rpm --rebuilddb --root="${EROOT}"
		else
			einfo "No RPM database found... Creating database..."
			"${EROOT}"/usr/bin/rpm --initdb --root="${EROOT}"
		fi
	fi
	chown rpm:rpm "${EROOT}"/var/lib/rpm/*

	python_mod_optimize rpm
}

pkg_postrm() {
	python_mod_cleanup rpm
}
