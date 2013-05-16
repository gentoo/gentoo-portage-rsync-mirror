# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vmaid/vmaid-2.2.0.ebuild,v 1.4 2013/05/16 19:24:51 ulm Exp $

EAPI=1

DESCRIPTION="Video maid is the AVI file editor"
HOMEPAGE="http://vmaid.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/vmaid/33098/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa ao mime"

RDEPEND="x11-libs/gtk+:2
	ao? ( media-libs/libao )
	!ao? ( alsa? ( >=media-libs/alsa-lib-0.9 ) )
	mime? ( x11-misc/shared-mime-info )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	app-text/scrollkeeper"

src_compile() {
	local myconf

	if use ao ; then
		myconf="${myconf} --with-ao=yes"
	elif use alsa ; then
		myconf="${myconf} --with-alsa=yes"
	fi

	econf \
		$(use_enable mime) \
		--without-w32 \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS CONTRIBUTORS ChangeLog NEWS README
	dohtml -r doc/{en,ja}
}
