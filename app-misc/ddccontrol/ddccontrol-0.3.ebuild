# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ddccontrol/ddccontrol-0.3.ebuild,v 1.3 2012/04/25 16:13:00 jlec Exp $

EAPI=1

DESCRIPTION="DDCControl allows control of monitor parameters via DDC"
HOMEPAGE="http://ddccontrol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gnome doc nls"

RDEPEND="dev-libs/libxml2:2
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	gnome? ( >=gnome-base/gnome-panel-2.10 )
	sys-apps/pciutils
	nls? ( sys-devel/gettext )
	>=app-misc/ddccontrol-db-20051114"
DEPEND="${RDEPEND}
	doc? ( >=app-text/docbook-xsl-stylesheets-1.65.1
		   >=dev-libs/libxslt-1.1.6
	       app-text/htmltidy )
	sys-kernel/linux-headers"

src_unpack() {
	unpack ${A}
	# Fix sandbox violation
	for i in Makefile.am Makefile.in; do
		sed -i.orig "${S}/src/gddccontrol/${i}" \
		-e "/@INSTALL@/s/ \$(datadir)/ \$(DESTDIR)\/\$(datadir)/" \
		|| die "Failed to fix DESTDIR"
	done
}

src_compile() {
	econf $(use_enable doc) \
		$(use_enable gtk gnome) \
		$(use_enable gnome gnome-applet) \
		$(use_enable nls)
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" htmldir="/usr/share/doc/${PF}/html" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
