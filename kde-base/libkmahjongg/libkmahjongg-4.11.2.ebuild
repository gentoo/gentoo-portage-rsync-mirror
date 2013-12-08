# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.11.2.ebuild,v 1.3 2013/12/08 14:07:36 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

PATCHES=( "${FILESDIR}/${P}-no-need-libkdegames.patch" )
