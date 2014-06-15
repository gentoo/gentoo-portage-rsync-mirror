# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libevdev/libevdev-1.2.1.ebuild,v 1.2 2014/06/15 14:29:33 hattya Exp $

EAPI=5
XORG_MULTILIB=yes
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit python-any-r1 xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}.git"

DESCRIPTION="Handler library for evdev events"

if [[ ${PV} == 9999* ]] ; then
	SRC_URI=""
else
	SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"
fi

RESTRICT="test" # Tests need to run as root.
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
