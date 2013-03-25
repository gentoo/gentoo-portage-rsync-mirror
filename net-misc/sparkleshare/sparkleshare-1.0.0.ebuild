# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sparkleshare/sparkleshare-1.0.0.ebuild,v 1.3 2013/03/25 16:37:38 ago Exp $

EAPI=5
GCONF_DEBUG="no" # --enable-debug does not do anything

inherit gnome2 mono multilib

DESCRIPTION="Git-based collaboration and file sharing tool"
HOMEPAGE="http://www.sparkleshare.org"
SRC_URI="http://github.com/downloads/hbons/SparkleShare/${PN}-linux-${PV}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="" # ayatana

COMMON_DEPEND=">=dev-lang/mono-2.8
	>=dev-dotnet/glib-sharp-2.12.7
	>=dev-dotnet/gtk-sharp-2.12.10
	dev-dotnet/notify-sharp
	dev-dotnet/webkit-sharp
"
RDEPEND="${COMMON_DEPEND}
	>=dev-vcs/git-1.7.12
	gnome-base/gvfs
	net-misc/curl[ssl]
	net-misc/openssh
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

src_prepare() {
	DOCS="News.txt legal/Authors.txt README.md"
	G2CONF+=" --disable-appindicator"
	#       $(use_enable ayatana appindicator)
	# requires >=appindicator-sharp-0.0.7
	gnome2_src_prepare
}
