# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-SDL/Alien-SDL-1.434.ebuild,v 1.4 2012/07/09 11:53:28 jer Exp $

EAPI=4

MODULE_AUTHOR=FROGGS
inherit perl-module

DESCRIPTION="building, finding and using SDL binaries"

SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

# Archive::Extract, File::Fetch, File::Find, Test::More -> dev-lang/perl
RDEPEND="dev-perl/Archive-Zip
	dev-perl/Capture-Tiny
	dev-perl/File-ShareDir
	dev-perl/File-Which
	dev-perl/Text-Patch
	media-libs/libsdl
	virtual/perl-Archive-Tar
	virtual/perl-Digest-SHA
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Module-Build
	virtual/perl-File-Spec
	virtual/perl-File-Temp"
DEPEND=${RDEPEND}

SRC_TEST=do
myconf='--with-sdl-config'
