# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.10.2.ebuild,v 1.6 2013/01/20 17:20:55 ago Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit eutils autotools flag-o-matic perl-module python versionator

DESCRIPTION="Red Hat Package Management Utils"
HOMEPAGE="http://www.rpm.org"
SRC_URI="http://rpm.org/releases/rpm-$(get_version_component_range 1-2).x/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86"

IUSE="nls python doc caps lua acl selinux"

RDEPEND="!app-arch/rpm5
	>=sys-libs/db-4.5
	>=sys-libs/zlib-1.2.3-r1
	>=app-arch/bzip2-1.0.1
	>=dev-libs/popt-1.7
	>=app-crypt/gnupg-1.2
	dev-libs/elfutils
	virtual/libintl
	>=dev-lang/perl-5.8.8
	dev-libs/nss
	python? ( >=dev-lang/python-2.3 )
	nls? ( virtual/libintl )
	lua? ( >=dev-lang/lua-5.1.0[deprecated] )
	acl? ( virtual/acl )
	caps? ( >=sys-libs/libcap-2.0 )
	selinux? ( sec-policy/selinux-rpm )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${PN}-4.8.1-db-path.patch \
		"${FILESDIR}"/${PN}-4.9.1.2-libdir.patch

	# fix #356769
	sed -i 's:%{_var}/tmp:/var/tmp:' macros.in || die "Fixing tmppath failed"

	eautoreconf

	# Prevent automake maintainer mode from kicking in (#450448).
	touch -r Makefile.am preinstall.am
}

src_configure() {
	econf \
		--without-selinux \
		--with-external-db \
		$(use_enable python) \
		$(use_with doc hackingdocs) \
		$(use_enable nls) \
		$(use_with lua) \
		$(use_with caps cap) \
		$(use_with acl)
}

src_compile() {
	default
}

src_install() {
	default

	# remove la files
	find "${ED}" -name '*.la' -exec rm -f {} +

	mv "${ED}"/bin/rpm "${ED}"/usr/bin
	rmdir "${ED}"/bin
	# fix symlinks to /bin/rpm (#349840)
	for binary in rpmquery rpmverify;do
		ln -sf rpm "${ED}"/usr/bin/${binary}
	done

	use nls || rm -rf "${ED}"/usr/share/man/??

	keepdir /usr/src/rpm/{SRPMS,SPECS,SOURCES,RPMS,BUILD}

	dodoc CHANGES CREDITS GROUPS README*
	if use doc; then
		pushd doc/hacking/html
		dohtml -p hacking -r .
		popd
		pushd doc/librpm/html
		dohtml -p librpm -r .
		popd
	fi

	# Fix perllocal.pod file collision
	fixlocalpod
}

pkg_postinst() {
	if [[ -f "${EROOT}"/var/lib/rpm/Packages ]] ; then
		einfo "RPM database found... Rebuilding database (may take a while)..."
		"${EROOT}"/usr/bin/rpmdb --rebuilddb --root="${EROOT}"
	else
		einfo "No RPM database found... Creating database..."
		"${EROOT}"/usr/bin/rpmdb --initdb --root="${EROOT}"
	fi

	use python && python_mod_optimize rpm
}

pkg_postrm() {
	use python && python_mod_cleanup rpm
}
