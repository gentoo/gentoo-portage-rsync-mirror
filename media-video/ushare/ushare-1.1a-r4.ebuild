# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ushare/ushare-1.1a-r4.ebuild,v 1.1 2012/08/18 15:06:05 hwoarang Exp $

EAPI=4
inherit eutils multilib user

DESCRIPTION="uShare is a UPnP (TM) A/V & DLNA Media Server"
HOMEPAGE="http://ushare.geexbox.org/"
SRC_URI="http://ushare.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dlna nls"

RDEPEND=">=net-libs/libupnp-1.6.14
	dlna? ( >=media-libs/libdlna-0.2.4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	EPATCH_SOURCE="${FILESDIR}" EPATCH_SUFFIX="patch" \
		EPATCH_OPTS="-p1" epatch
}

src_configure() {
	local myconf
	myconf="--prefix=/usr --disable-sysconf --disable-strip $(use_enable dlna)"
	# nls can only be disabled, on by default.
	use nls || myconf="${myconf} --disable-nls"

	# I can't use econf
	# --host is not implemented in ./configure file
	./configure ${myconf} || die "./configure failed"
}

src_install() {
	emake DESTDIR="${D}" install
	doman src/ushare.1
	newconfd "${FILESDIR}"/ushare.conf.d ushare
	newinitd "${FILESDIR}"/ushare.init.d ushare
	dodoc NEWS README TODO THANKS AUTHORS
}

pkg_postinst() {
	enewuser ushare
	elog "Please edit /etc/conf.d/ushare to set the shared directories"
	elog "and other important settings. Check system log if ushare is"
	elog "not booting."
}
