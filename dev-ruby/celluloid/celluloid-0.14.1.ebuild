# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/celluloid/celluloid-0.14.1.ebuild,v 1.1 2013/07/13 06:04:51 graaff Exp $

EAPI=5
# rbx or jruby recommended, but only in 1.9 mode.
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="Celluloid provides a simple and natural way to build fault-tolerant concurrent programs in Ruby"
HOMEPAGE="https://github.com/celluloid/celluloid"
SRC_URI="https://github.com/celluloid/celluloid/archive/v${PV}.tar.gz -> ${P}-git.tgz"
IUSE=""
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64"

ruby_add_rdepend ">=dev-ruby/timers-1.0.0"

all_ruby_prepare() {
	rm Gemfile .rspec || die

	sed -i -e '/coveralls/I s:^:#:' spec/spec_helper.rb || die
}
