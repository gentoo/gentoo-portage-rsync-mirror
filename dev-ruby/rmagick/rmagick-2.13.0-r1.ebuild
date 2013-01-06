# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-2.13.0-r1.ebuild,v 1.14 2012/07/01 18:31:37 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="ChangeLog README.html README-Mac-OSX.txt"

inherit ruby-fakegem

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="mirror://rubyforge/rmagick/RMagick-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc ppc64 x86"
IUSE="doc"

# hdri causes extensive changes in the imagemagick internals, and
# rmagick is not ready to deal with those, see bug 184356.
RDEPEND=">=media-gfx/imagemagick-6.4.9[-hdri]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/RMagick-${PV}"

RUBY_PATCHES=( "rmagick-2.13.0-magicklibsubversion.patch" )

each_ruby_configure() {
	pushd ext/RMagick
	${RUBY} extconf.rb || die "extconf.rb failed"
	popd

}

each_ruby_compile() {
	pushd ext/RMagick
	emake || die "emake failed"
	popd
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/RMagick/RMagick2.so lib/RMagick2.so
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die "failed to install examples"

	if use doc ; then
		dohtml -r doc || die "failed to install documentation"
	fi
}
