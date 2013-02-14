# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/wacomtablet/wacomtablet-1.3.7.2.ebuild,v 1.1 2013/02/14 16:25:25 creffett Exp $

EAPI=4

MY_P=${PN}-v${PV}
KDE_LINGUAS="bs cs da de el en_GB eo es et fi fr ga hu ja kk km lt mai nb nds nl pa pl pt
pt_BR ro sk sl sv tr ug uk zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base versionator
MY_PV="$(replace_version_separator 3 '-')"
MY_P=${PN}-${MY_PV}

DESCRIPTION="KControl module for wacom tablets"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=114856"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/114856-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="sys-devel/gettext"
RDEPEND="${DEPEND}
	>=x11-drivers/xf86-input-wacom-0.11.0
"

S=${WORKDIR}/${MY_P}
