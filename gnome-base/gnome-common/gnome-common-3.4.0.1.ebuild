# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-common/gnome-common-3.4.0.1.ebuild,v 1.1 2012/08/10 11:02:01 eva Exp $

EAPI="4"

inherit gnome.org

DESCRIPTION="Common files for development of Gnome packages"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_install() {
	default
	mv doc-build/README README.doc-build || die "renaming doc-build/README failed"
	dodoc ChangeLog README* doc/usage.txt
}
