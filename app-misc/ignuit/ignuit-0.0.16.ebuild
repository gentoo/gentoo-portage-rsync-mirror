# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ignuit/ignuit-0.0.16.ebuild,v 1.6 2011/03/27 12:02:49 nirbheek Exp $

EAPI="2"

DESCRIPTION="memorization aid based on the Leitner flashcard system"
HOMEPAGE="http://homepages.ihug.co.nz/~trmusson/programs.html#ignuit"
SRC_URI="http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="examples"

RDEPEND=">=gnome-base/libgnomeui-2.22.1
	gnome-base/gconf:2
	gnome-base/libglade:2.0
	dev-libs/glib:2
	x11-libs/gtk+:2
	>=media-libs/gstreamer-0.10.20:0.10
	dev-libs/libxslt
	dev-libs/libxml2:2
	x11-libs/pango
	app-text/dvipng
	virtual/latex-base
	>=app-text/gnome-doc-utils-0.3.2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
