# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arel/arel-6.0.0.ebuild,v 1.2 2015/03/24 16:12:45 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.markdown"

RUBY_FAKEGEM_GEMSPEC="arel.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Arel is a Relational Algebra for Ruby"
HOMEPAGE="http://github.com/rails/arel"
SRC_URI="https://github.com/rails/arel/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/bundler
		dev-ruby/test-unit:2
		>=dev-ruby/minitest-5.4:5
	)"
