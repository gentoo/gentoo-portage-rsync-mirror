# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kremotecontrol/kremotecontrol-4.11.0.ebuild,v 1.1 2013/08/14 20:23:29 dilfridge Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE frontend for the Linux Infrared Remote Control system"
HOMEPAGE="http://kde.org/applications/utilities/kremotecontrol
http://utils.kde.org/projects/kremotecontrol"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}
	app-misc/lirc
"
