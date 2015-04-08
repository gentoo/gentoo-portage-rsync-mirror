# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/celluloid/celluloid-0.16.0.ebuild,v 1.1 2014/11/02 11:05:58 graaff Exp $

EAPI=5
# rbx or jruby recommended, but only in 1.9 mode.
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
#Needed by dev-ruby/listen
RUBY_FAKEGEM_EXTRAINSTALL="spec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Celluloid provides a simple and natural way to build fault-tolerant concurrent programs in Ruby"
HOMEPAGE="https://github.com/celluloid/celluloid"
SRC_URI="https://github.com/celluloid/celluloid/archive/v${PV}.tar.gz -> ${P}-git.tgz"
IUSE=""
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~ppc64"

RUBY_PATCHES=( "${P}-call-private-methods.patch" )

ruby_add_rdepend ">=dev-ruby/timers-4.0.0:4"

all_ruby_prepare() {
	rm Gemfile .rspec || die

	sed -i -e '/[Bb]undler/d' -e '/coveralls/I s:^:#:' spec/spec_helper.rb || die

	# Force loading of the correct timers slot to avoid a bundler dependency.
	sed -i -e '3igem "timers", "~>4.0.0"' spec/spec_helper.rb || die
}
