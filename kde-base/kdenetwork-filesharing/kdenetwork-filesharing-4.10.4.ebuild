# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-filesharing/kdenetwork-filesharing-4.10.4.ebuild,v 1.3 2013/06/29 16:08:54 ago Exp $

EAPI=5

KMNAME="kdenetwork"
KMMODULE="filesharing"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="kcontrol filesharing config module for SMB"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
