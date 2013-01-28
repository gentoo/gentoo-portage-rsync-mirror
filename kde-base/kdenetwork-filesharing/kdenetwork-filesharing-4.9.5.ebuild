# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-filesharing/kdenetwork-filesharing-4.9.5.ebuild,v 1.4 2013/01/27 23:19:47 ago Exp $

EAPI=4

KMNAME="kdenetwork"
KMMODULE="filesharing"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="kcontrol filesharing config module for NFS, SMB etc"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"
