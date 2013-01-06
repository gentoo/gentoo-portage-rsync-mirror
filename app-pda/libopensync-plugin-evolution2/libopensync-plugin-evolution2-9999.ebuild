# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-evolution2/libopensync-plugin-evolution2-9999.ebuild,v 1.3 2009/11/16 00:16:43 mr_bones_ Exp $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="OpenSync Evolution 2 Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/evolution2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2
	gnome-extra/evolution-data-server"
DEPEND="${RDEPEND}"

# interactive and broken
RESTRICT="test"
