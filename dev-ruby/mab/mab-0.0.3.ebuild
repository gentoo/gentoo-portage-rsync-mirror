# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mab/mab-0.0.3.ebuild,v 1.1 2013/03/14 06:33:59 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Markup as Ruby"
HOMEPAGE="http://github.com/camping/mab"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

ruby_add_bdepend "
	test? ( dev-ruby/minitest )"
