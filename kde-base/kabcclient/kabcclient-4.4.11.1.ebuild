# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kabcclient/kabcclient-4.4.11.1.ebuild,v 1.8 2013/10/10 05:26:53 creffett Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="console/${PN}"
inherit kde4-meta

DESCRIPTION="A command line client for accessing the KDE addressbook"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-meta_src_install

	# work around NULL DT_RPATH in kabc2mutt
	dosym kabcclient ${PREFIX}/bin/kabc2mutt || die "couldn't symlink kabc2mutt to kabcclient"
}
