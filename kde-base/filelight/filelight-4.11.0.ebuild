# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/filelight/filelight-4.11.0.ebuild,v 1.1 2013/08/14 20:23:32 dilfridge Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."
HOMEPAGE="http://utils.kde.org/projects/filelight"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-apps/xdpyinfo
"
