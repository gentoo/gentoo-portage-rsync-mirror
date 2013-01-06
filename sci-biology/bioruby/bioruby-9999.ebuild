# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioruby/bioruby-9999.ebuild,v 1.2 2011/09/20 22:11:00 mgorny Exp $

EAPI="2"

EGIT_REPO_URI="git://github.com/bioruby/bioruby.git
	https://github.com/bioruby/bioruby.git"

inherit ruby git-2

DESCRIPTION="An integrated environment for bioinformatics using the Ruby language"
LICENSE="Ruby"
HOMEPAGE="http://www.bioruby.org/"
#SRC_URI="http://www.${PN}.org/archive/${P}.tar.gz"
SRC_URI=""

SLOT="0"
IUSE=""
KEYWORDS=""

USE_RUBY="ruby18"

src_install() {
	${RUBY} setup.rb install --prefix="${D}"
}

src_test() {
	# NB: Some tests fail but don't raise an error.
	${RUBY} setup.rb test || die
}
