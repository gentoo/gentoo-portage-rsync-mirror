# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/yate/yate-2.0.0.ebuild,v 1.6 2013/03/02 23:11:40 hwoarang Exp $

EAPI="2"

inherit autotools eutils multilib

DESCRIPTION="Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://yate.null.ro/tarballs/yate2/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug doc gsm h323 ilbc mysql oss postgres qt4 sctp spandsp
speex ssl"

RDEPEND="
	sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	gsm? ( media-sound/gsm )
	h323? ( dev-libs/pwlib
		net-libs/openh323 )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	mysql? ( virtual/mysql )
	oss? ( sys-kernel/linux-headers )
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

	epatch "${FILESDIR}"/${P}-ilbc-alsa-oss.patch
	epatch "${FILESDIR}"/${P}-cxxflags.patch
	epatch "${FILESDIR}"/${P}-spandsp.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

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
		$(use_enable alsa) \
		$(use_with gsm libgsm) \
		$(use_with h323 openh323 /usr) \
		$(use_with h323 pwlib /usr) \
		$(use_enable ilbc) \
		$(use_with mysql mysql /usr) \
		$(use_enable oss) \
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
		emake ddebug || die "emake ddebug failed"
	else
		default_src_compile
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
