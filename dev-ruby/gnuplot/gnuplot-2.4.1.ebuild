# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gnuplot/gnuplot-2.4.1.ebuild,v 1.2 2012/07/01 18:31:45 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="AUTHORS.txt ChangeLog README.textile"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Gnuplot drawing library - Ruby Bindings"
HOMEPAGE="http://rgplot.rubyforge.org/"

LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"
SLOT="0"

RDEPEND="${RDEPEND} sci-visualization/gnuplot"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Existing metadata causes a crash in jruby, so use our own.
	rm ../metadata || die "Unable to remove metadata."
}

each_ruby_test() {
	${RUBY} -Ctest test_gnuplot.rb || die
}
