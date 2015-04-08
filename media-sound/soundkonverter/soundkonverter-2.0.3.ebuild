# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-2.0.3.ebuild,v 1.4 2014/03/15 07:31:23 kensington Exp $

EAPI=5

KDE_LINGUAS="cs de es et fr hu it pt pt_BR ru"
inherit kde4-base

DESCRIPTION="Frontend to various audio converters"
HOMEPAGE="http://www.kde-apps.org/content/show.php/soundKonverter?content=29024"
SRC_URI="http://kde-apps.org/CONTENT/content-files/29024-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep libkcddb)
	media-libs/taglib
	media-sound/cdparanoia
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

pkg_postinst() {
	elog "soundKonverter optionally supports many different audio formats."
	elog "You will need to install the appropriate encoding packages for the"
	elog "formats you require. For a full listing, consult the README file"
	elog "in /usr/share/doc/${PF}"
}
