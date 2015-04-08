# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-script-source/coffee-script-source-1.8.0.ebuild,v 1.3 2015/01/29 06:51:00 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Ruby CoffeeScript is a bridge to the official CoffeeScript compiler"
HOMEPAGE="http://jashkenas.github.io/coffee-script/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x64-macos ~x86-solaris"

IUSE=""
