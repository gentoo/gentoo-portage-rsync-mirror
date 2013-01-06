# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-1.81.0.ebuild,v 1.7 2012/05/04 04:10:57 jdhore Exp $

EAPI=4

MY_PN=Gnome2-VFS
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.081
inherit perl-module

DESCRIPTION="Perl interface to the 2.x series of the Gnome Virtual File System libraries."

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2
	>=dev-perl/glib-perl-1.120"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.2
	>=dev-perl/extutils-pkgconfig-1.03
	virtual/pkgconfig"

SRC_TEST=do

src_test(){
	if [[ ${EUID} == 0 || ${HOME} = /root ]] ; then
		ewarn "Test skipped. Don't run tests as root."
		return
	fi
	mkdir "${HOME}/.gnome"
	perl-module_src_test
}
