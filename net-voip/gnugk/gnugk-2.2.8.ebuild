# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/gnugk/gnugk-2.2.8.ebuild,v 1.2 2010/06/17 20:58:55 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="GNU H.323 gatekeeper"
HOMEPAGE="http://www.gnugk.org/"
SRC_URI="mirror://sourceforge/openh323gk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# dev-db/firebird isn't keyworded for ppc but firebird IUSE is masked for ppc
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc firebird mysql odbc postgres radius sqlite linguas_en linguas_es linguas_fr"

# TODO: when h323plus will be in portage tree, add it as || dep with openh323
RDEPEND=">=dev-libs/pwlib-1.7.5.2
	>=net-libs/openh323-1.14.2
	dev-libs/openssl
	firebird? ( dev-db/firebird )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	doc? ( app-text/linuxdoc-tools )"

pkg_setup() {
	if use doc && ! use linguas_en && ! use linguas_es && ! use linguas_fr; then
		elog "No linguas specified."
		elog "English documentation will be installed."
	fi
}

src_prepare() {
	# fix build with firebird 2.1
	# upstream has been contacted, watch if fixed in next releases
	use firebird && epatch "${FILESDIR}"/${P}-firebird-2.1.patch
}

src_configure() {
	# --with-large-fdset=4096 is added because of bug #128102
	# and it is recommanded in the online manual
	econf \
		$(use_enable firebird) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable odbc unixodbc) \
		$(use_enable radius) \
		$(use_enable sqlite) \
		--with-large-fdset=4096
}

src_compile() {
	# PASN_NOPRINT should be set for -debug but it's buggy
	# better to prevent issues and keep default settings
	# `make debugdepend debugshared` and `make debug` failed (so no debug)
	# `make optdepend optnoshared` also failed (so no static)

	# splitting emake calls fixes parallel build issue
	emake optdepend || die "emake optdepend failed"
	emake optshared || die "emake optshared failed"

	# build tool addpasswd
	emake addpasswd || die "emake addpasswd failed"

	if use doc; then
		cd docs/manual

		if use linguas_en || ( ! use linguas_es && ! use linguas_fr ); then
			emake html || die "emake en doc failed"
		fi

		if use linguas_es; then
			emake html-es || die "emake es doc failed"
		fi

		if use linguas_fr; then
			emake html-fr || die "emake fr doc failed"
		fi
		cd ../..
	fi
}

src_install() {
	dosbin obj_*_*_*/${PN} || die "dosbin failed"
	dosbin obj_*_*_*/addpasswd || die "dosbin failed"

	dodir /etc/${PN}
	insinto /etc/${PN}
	doins etc/* || die "doins etc/* failed"

	dodoc changes.txt readme.txt p2pnat_license.txt || die "dodoc failed"

	if use doc; then
		dodoc docs/*.txt docs/*.pdf || die "dodoc failed"

		if use linguas_en || ( ! use linguas_es && ! use linguas_fr ); then
			dohtml docs/manual/manual*.html || die "dohtml failed"
		fi
		if use linguas_fr; then
			dohtml docs/manual/fr/manual-fr*.html || die "dohtml failed"
		fi
		if use linguas_es; then
			dohtml docs/manual/es/manual-es*.html || die "dohtml failed"
		fi
	fi

	doman docs/${PN}.1 || die "doman failed"

	newinitd "${FILESDIR}"/${PN}.rc6 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
