# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-2.2.ebuild,v 1.9 2012/08/11 16:01:29 jer Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"

inherit eutils flag-o-matic libtool python

DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="mirror://gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="amd64 ~hppa ~ppc x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE="bidi gdbm guile ldap mysql nls pam postgres python test tokyocabinet"

RDEPEND="!mail-client/nmh
	!mail-filter/libsieve
	!mail-client/mailx
	!mail-client/nail
	bidi? ( dev-libs/fribidi )
	guile? ( dev-scheme/guile )
	gdbm? ( sys-libs/gdbm )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	nls? ( sys-devel/gettext )
	postgres? ( dev-db/postgresql-base )
	tokyocabinet? ( dev-db/tokyocabinet )
	virtual/mta"

DEPEND="${RDEPEND}
	test? ( dev-util/dejagnu )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1-python.patch \
		"${FILESDIR}"/${P}-gets.patch
	elibtoolize  # for Darwin bundles

	# Disable bytecompilation of Python modules.
	echo "#!/bin/sh" > build-aux/py-compile
}

src_configure() {
	# TODO: Fix this breakage, starting in examples/cpp/
	append-ldflags $(no-as-needed)

	local myconf="--localstatedir=${EPREFIX}/var --sharedstatedir=${EPREFIX}/var"
	myconf="${myconf} --enable-mh"

	# We need sendmail or compiling will fail
	myconf="${myconf} --enable-sendmail"

	econf ${myconf} \
		$(use_with bidi fribidi) \
		$(use_with gdbm) \
		$(use_with guile) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_enable nls) \
		$(use_enable pam) \
		$(use_with postgres) \
		$(use_with python) \
		$(use_with tokyocabinet)
}

src_install() {
	emake DESTDIR="${D}" install || die
	# mail.rc stolen from mailx, resolve bug #37302.
	insinto /etc
	doins "${FILESDIR}/mail.rc"

	if use python; then
		python_clean_installation_image
		rm -f "${ED}$(python_get_sitedir)/mailutils/c_api.a"
	fi
}

pkg_postinst() {
	if use python; then
		python_mod_optimize mailutils
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup mailutils
	fi
}
