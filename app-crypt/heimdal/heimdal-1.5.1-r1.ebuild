# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-1.5.1-r1.ebuild,v 1.11 2012/05/31 03:25:16 zmedico Exp $

EAPI=2
# PYTHON_BDEPEND="2"
VIRTUALX_REQUIRED="manual"

inherit autotools db-use eutils multilib python toolchain-funcs virtualx flag-o-matic

MY_P="${P}"
DESCRIPTION="Kerberos 5 implementation from KTH"
HOMEPAGE="http://www.h5l.org/"
SRC_URI="http://www.h5l.org/dist/src/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="afs +berkdb caps hdb-ldap ipv6 otp +pkinit ssl static-libs threads test X"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	!berkdb? ( sys-libs/gdbm )
	caps? ( sys-libs/libcap-ng )
	>=dev-db/sqlite-3.5.7
	>=sys-libs/e2fsprogs-libs-1.41.11
	sys-libs/ncurses
	sys-libs/readline
	afs? ( net-fs/openafs )
	hdb-ldap? ( >=net-nds/openldap-2.3.0 )
	X? ( x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXt )
	!!app-crypt/mit-krb5
	!!app-crypt/mit-krb5-appl"

DEPEND="${RDEPEND}
	=dev-lang/python-2*
	virtual/pkgconfig
	>=sys-devel/autoconf-2.62
	test? ( X? ( ${VIRTUALX_DEPEND} ) )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/heimdal_missing-include.patch"
	epatch "${FILESDIR}/CVE-2011-4862.patch"
	epatch "${FILESDIR}/heimdal_db5.patch"
	epatch "${FILESDIR}/heimdal_disable-check-iprop.patch"
	epatch "${FILESDIR}/heimdal_link_order.patch"
	eautoreconf
}

src_configure() {
	# QA
	append-flags -fno-strict-aliasing

	local myconf=""
	if use berkdb; then
		myconf="--with-berkeley-db --with-berkeley-db-include=$(db_includedir)"
	else
		myconf="--without-berkeley-db"
	fi
	econf \
		--enable-kcm \
		--disable-osfc2 \
		--enable-shared \
		--with-libintl=/usr \
		--with-readline=/usr \
		--with-sqlite3=/usr \
		--libexecdir=/usr/sbin \
		$(use_enable afs afs-support) \
		$(use_enable otp) \
		$(use_enable pkinit kx509) \
		$(use_enable pkinit pk-init) \
		$(use_enable static-libs static) \
		$(use_enable threads pthread-support) \
		$(use_with caps capng) \
		$(use_with hdb-ldap openldap /usr) \
		$(use_with ipv6) \
		$(use_with ssl openssl /usr) \
		$(use_with X x) \
		${myconf}
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	INSTALL_CATPAGES="no" emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd,rshd,popper}
	do
		mv "${D}"/usr/share/man/man8/{,k}${i}.8
		mv "${D}"/usr/sbin/{,k}${i}
	done

	for i in {rcp,rsh,telnet,ftp,su,login,pagsh,kf}
	do
		mv "${D}"/usr/share/man/man1/{,k}${i}.1
		mv "${D}"/usr/bin/{,k}${i}
	done

	mv "${D}"/usr/share/man/man5/{,k}ftpusers.5
	mv "${D}"/usr/share/man/man5/{,k}login.access.5

	newinitd "${FILESDIR}"/heimdal-kdc.initd-r1 heimdal-kdc
	newinitd "${FILESDIR}"/heimdal-kadmind.initd-r1 heimdal-kadmind
	newinitd "${FILESDIR}"/heimdal-kpasswdd.initd-r1 heimdal-kpasswdd
	newinitd "${FILESDIR}"/heimdal-kcm.initd-r1 heimdal-kcm

	newconfd "${FILESDIR}"/heimdal-kdc.confd heimdal-kdc
	newconfd "${FILESDIR}"/heimdal-kadmind.confd heimdal-kadmind
	newconfd "${FILESDIR}"/heimdal-kpasswdd.confd heimdal-kpasswdd
	newconfd "${FILESDIR}"/heimdal-kcm.confd heimdal-kcm

	insinto /etc
	newins "${FILESDIR}"/krb5.conf krb5.conf.example

	if use hdb-ldap; then
		insinto /etc/openldap/schema
		doins "${S}/lib/hdb/hdb.schema"
	fi

	use static-libs || find "${D}"/usr/lib* -name '*.la' -delete

	# default database dir
	keepdir /var/heimdal

	# Ugly hack for broken symlink - bug #417081
	rm "${D}"/usr/share/man/man5/qop.5 || die
	dosym mech.5 /usr/share/man/man5/qop.5
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libgssapi.so.2
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libgssapi.so.2
}
