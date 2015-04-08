# Copyright 2006-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-panel/matchbox-panel-0.9.3.ebuild,v 1.7 2009/03/14 03:52:35 solar Exp $

inherit eutils versionator

DESCRIPTION="The Matchbox Panel"
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="acpi debug dnotify lowres nls startup-notification"

DEPEND=">=x11-libs/libmatchbox-1.5
	startup-notification? ( x11-libs/startup-notification )
	nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}
	x11-wm/matchbox-common"

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/"${P}-gcc4-no-nested-functions.patch
}

src_compile() {
	econf	$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable startup-notification) \
		$(use_enable dnotify) \
		$(use_enable acpi acpi-linux) \
		$(use_enable lowres small-icons) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
