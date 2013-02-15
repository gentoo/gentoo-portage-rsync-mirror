# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motion/motion-3.2.12-r2.ebuild,v 1.4 2013/02/15 19:17:27 aballier Exp $

EAPI=4
inherit eutils user

DESCRIPTION="A software motion detector"
HOMEPAGE="http://www.lavrsen.dk/twiki/bin/view/Motion/WebHome"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc x86"
IUSE="ffmpeg mysql postgres +v4l"

RDEPEND="sys-libs/zlib
	virtual/jpeg
	ffmpeg? ( virtual/ffmpeg )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )"
# note: libv4l is only in dependencies for the libv4l1-videodev.h header file
# used by the -workaround-v4l1_deprecation.patch.
DEPEND="${RDEPEND}
	v4l? ( virtual/os-headers media-libs/libv4l )"

pkg_setup() {
	enewuser motion -1 -1 -1 video
}

src_prepare() {
	epatch \
		"${FILESDIR}"/ffmpeg08.patch \
		"${FILESDIR}"/ffmpeg1.patch \
		"${FILESDIR}"/${P}-workaround-v4l1_deprecation.patch
}

src_configure() {
	econf \
		$(use_with v4l) \
		$(use_with ffmpeg) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		--without-optimizecpu
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DOC='CHANGELOG CODE_STANDARD CREDITS FAQ README' \
		docdir=/usr/share/doc/${PF} \
		EXAMPLES='thread*.conf' \
		examplesdir=/usr/share/doc/${PF}/examples \
		install

	dohtml *.html

	newinitd "${FILESDIR}"/motion.initd-r2 motion
	newconfd "${FILESDIR}"/motion.confd motion

	mv -vf "${D}"/etc/motion{-dist,}.conf || die
}

pkg_postinst() {
	elog "You need to setup /etc/motion.conf before running"
	elog "motion for the first time."
	elog "You can install motion detection as a service, use:"
	elog "rc-update add motion default"
}
