# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tilt/tilt-1.4.1.ebuild,v 1.2 2013/08/08 19:31:09 maekke Exp $

EAPI=5

# jruby fails tests
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md TEMPLATES.md"

inherit ruby-fakegem

DESCRIPTION="A thin interface over a Ruby template engines to make their usage as generic as possible."
HOMEPAGE="http://github.com/rtomayko/tilt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit
	dev-ruby/bluecloth
	dev-ruby/coffee-script
	dev-ruby/erubis
	dev-ruby/haml
	dev-ruby/nokogiri
	dev-ruby/radius )"
ruby_add_rdepend ">=dev-ruby/builder-2.0.0"
