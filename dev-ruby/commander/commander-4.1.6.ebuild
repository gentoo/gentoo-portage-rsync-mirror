# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/commander/commander-4.1.6.ebuild,v 1.1 2014/02/12 06:59:14 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="History.rdoc README.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="The complete solution for Ruby command-line executables"
HOMEPAGE="http://visionmedia.github.com/commander/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/highline-1.6.11"

all_ruby_prepare() {
	sed -i -e "/[Ss]imple[Cc]ov/d" spec/spec_helper.rb || die
}
