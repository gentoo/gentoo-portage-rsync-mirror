# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/yate/yate-4.3.0.1.ebuild,v 1.1 2013/06/18 15:55:32 chithanh Exp $

EAPI=5

inherit autotools eutils multilib versionator

DESCRIPTION="Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://yate.null.ro/tarballs/yate$(get_major_version)/$(replace_version_separator 4 - ${P}).tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dahdi debug doc gsm h323 ilbc mysql oss postgres qt4 sctp spandsp speex sse2 ssl"

RDEPEND="
	dahdi? ( net-misc/dahdi )
	h323? ( net-libs/h323plus )
	gsm? ( media-sound/gsm )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtgui:4 )
	spandsp? ( >=media-libs/spandsp-0.0.3 )
	speex? ( media-libs/speex )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

# NOTES:
# doc is already built

# TODO:
# coredumper can't be used because not in the tree, bug 118716
# wanpipe can't be used because not in the tree (but voip overlay), bug 188939
# spandsp >= 0.0.6 fails in configure and >=0.0.5 fails in build
# fix bug 199222 for this version

src_prepare() {
	# add Icon in yate-qt4 desktop file
	sed -i -e '/^Exec=yate-qt4$/a Icon=null_team-32.png' \
		clients/yate-qt4.desktop || die "sed failed"

	epatch "${FILESDIR}"/${PN}-4.3.0-ilbc-alsa-oss.patch

	eautoreconf
}

src_configure() {
	# fdsize, inline, rtti: keep default values
	# internalregex: use system
	# coredumper: not in the tree, bug 118716
	# wanpipe, wphwec: not in the tree, bug 188939
	# doxygen, kdoc: no need to rebuild already built doc
	econf \
		--disable-internalregex \
		--without-coredumper \
		--disable-wanpipe \
		--without-wphwec \
		--without-doxygen \
		--without-kdoc \
		--with-archlib=$(get_libdir) \
		--without-amrnb \
		$(use_enable dahdi) \
		$(use_with gsm libgsm) \
		$(use_with h323 openh323) \
		$(use_with h323 pwlib) \
		$(use_enable ilbc) \
		$(use_with mysql mysql /usr) \
		$(use_with postgres libpq /usr) \
		$(use_with qt4 libqt4) \
		$(use_enable sctp) \
		$(use_with spandsp) \
		$(use_with speex libspeex) \
		$(use_with ssl openssl) \
		--disable-zaptel
}

src_compile() {
	if use debug; then
		emake -j1 ddebug || die "emake ddebug failed"
	else
		emake -j1
	fi
}

src_test() {
	# there is no real test suite
	# 'make test' tries to execute non-existing ./test
	# do not add RESTRICT="test" because it's not a failing test suite
	:
}

src_install() {
	emake DESTDIR="${D}" install-noapi || die "emake install-noapi failed"

	dodoc ChangeLog README || die "dodoc failed"

	insinto /etc/logrotate.d
	newins packing/${PN}.logrotate ${PN} || die "newins failed"

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die "newinitd failed"
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die "newconfd failed"

	if use doc; then
		emake DESTDIR="${D}" install-api || die "emake install-api failed"
	fi
}
